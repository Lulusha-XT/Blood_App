import { GridColDef } from "@mui/x-data-grid";
import DataTable from "../../components/dataTable/DataTable";
import "./Users.scss";
import { useEffect, useState } from "react";
import { User } from "../../types/user";
import { useUser } from "../../context/UserContext";
import Navbar from "../../components/navbar/Navbar";
import Footer from "../../components/footer/Footer";

const columns: GridColDef[] = [
  {
    field: "tokenOwner.userId",
    headerName: "ID",
    width: 300,
    valueGetter: (params) => params.row.tokenOwner.userId, // Custom valueGetter for ID
  },
  {
    field: "tokenOwner.fullName",
    headerName: "Full Name",
    width: 300,
    valueGetter: (params) => params.row.tokenOwner.fullName, // Custom valueGetter for Full Name
  },
  {
    field: "token",
    headerName: "Token",
    width: 300,
  },
];

const Users = () => {
  const [data, setData] = useState<User[]>([]);
  const { user } = useUser();

  useEffect(() => {
    if (user && user.user.token) {
      console.log(`Token: ${user.user.token}`);
      fetch(
        `http://127.0.0.1:8080/api/sponserToken?nocache=${new Date().getTime()}`,
        {
          method: "GET",
          headers: {
            Authorization: `Bearer ${user.user.token}`,
            "Content-Type": "application/json",
          },
        }
      )
        .then((response) => response.json())
        .then((responseData) => {
          if (Array.isArray(responseData.data)) {
            setData(responseData.data);
            console.log("Data (Array):", responseData.data);
          } else {
            setData([responseData.data]);
          }
        })
        .catch((error) => {
          console.error("Error fetching user data:", error);
        });
    }
  }, [user]);

  return (
    <div className="main">
      <Navbar />
      <div className="container">
        <div className="menuContainer">{/* <Menu /> */}</div>
        <div className="contentContainer">
          <div className="users">
            <div className="info">
              <h1>Users</h1>
            </div>
            <DataTable slug="users" columns={columns} rows={data} />
          </div>
        </div>
      </div>
      <Footer />
    </div>
  );
};

export default Users;
