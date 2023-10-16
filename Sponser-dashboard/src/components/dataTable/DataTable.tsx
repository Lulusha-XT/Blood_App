import React from "react";
import { DataGrid, GridColDef, GridToolbar } from "@mui/x-data-grid";
import { useUser } from "../../context/UserContext";
import "./dataTable.scss";

type Props = {
  columns: GridColDef[];
  rows: object[];
  slug: string;
};

const DataTable = (props: Props) => {
  const { user } = useUser();

  const handleDelete = (id: string, token: string) => {
    // Define the data to send in the request body
    const requestData = {
      tokenValue: token,
      userId: id,
    };
    console.log(requestData);

    // Send a DELETE request to the API endpoint with the data in the request body
    fetch(`http://localhost:8080/api/user/token/use`, {
      method: "POST",
      headers: {
        Authorization: `Bearer ${user!.user.token}`,
        "Content-Type": "application/json",
      },
      body: JSON.stringify(requestData), // Include the requestData in the request body
    })
      .then((response) => {
        if (response.ok) {
          // The DELETE request was successful, you can handle any success actions here
          console.log(`Deleted item with ID: ${id}`);
        } else {
          // Handle errors if the DELETE request fails
          console.error(`Error deleting item with ID: ${id}`);
        }
      })
      .catch((error) => {
        // Handle network or other errors here
        console.error("Error deleting item:", error);
      });
  };

  const actionColumn: GridColDef = {
    field: "action",
    headerName: "Action",
    width: 200,
    renderCell: (params) => {
      return (
        <div className="action">
          <button
            className="grant-token-button"
            onClick={() =>
              handleDelete(params.row.tokenOwner.userId, params.row.token)
            }
          >
            Grant Token
          </button>
        </div>
      );
    },
  };

  return (
    <div className="dataTable">
      <DataGrid
        className="dataGrid"
        rows={props.rows}
        columns={[...props.columns, actionColumn]}
        initialState={{
          pagination: {
            paginationModel: {
              pageSize: 10,
            },
          },
        }}
        slots={{ toolbar: GridToolbar }}
        slotProps={{
          toolbar: {
            showQuickFilter: true,
            quickFilterProps: { debounceMs: 500 },
          },
        }}
        pageSizeOptions={[5]}
        checkboxSelection
        disableRowSelectionOnClick
        disableColumnFilter
        disableDensitySelector
        disableColumnSelector
        getRowId={(row) => row.donationId}
      />
    </div>
  );
};

export default DataTable;
