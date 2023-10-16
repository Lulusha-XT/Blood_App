import { GridColDef } from "@mui/x-data-grid";
import "./add.scss";
import { useState } from "react";

type Props = {
  slug: string;
  columns: GridColDef[];
  setOpen: React.Dispatch<React.SetStateAction<boolean>>;
  onAddUser: (newUser: any) => void; // Callback to add a new user
};

const Add = (props: Props) => {
  const [formData, setFormData] = useState<any>({});

  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();

    try {
      // Send a POST request to your server to add a new user
      const response = await fetch(`http://localhost:8800/api/${props.slug}s`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(formData),
      });

      if (response.ok) {
        const newUser = await response.json();
        props.onAddUser(newUser); // Call the callback to add the new user to your UI
        props.setOpen(false); // Close the modal
      } else {
        // Handle errors or show a message to the user
        console.error(
          "Error adding user:",
          response.status,
          response.statusText
        );
      }
    } catch (error) {
      console.error("Error adding user:", error);
    }
  };

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setFormData((prevData: any) => ({ ...prevData, [name]: value }));
  };

  return (
    <div className="add">
      <div className="modal">
        <span className="close" onClick={() => props.setOpen(false)}>
          X
        </span>
        <h1>Add new {props.slug}</h1>
        <form onSubmit={handleSubmit}>
          {props.columns
            .filter((item) => item.field !== "id")
            .map((column) => (
              <div className="item" key={column.field}>
                <label>{column.headerName}</label>
                <input
                  type={column.type === "number" ? "number" : "text"}
                  placeholder={column.headerName}
                  name={column.field}
                  value={formData[column.field] || ""}
                  onChange={handleInputChange}
                  required
                />
              </div>
            ))}
          <button type="submit">Send</button>
        </form>
      </div>
    </div>
  );
};

export default Add;
