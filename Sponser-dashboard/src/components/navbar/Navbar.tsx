import { useUser } from "./../../context/UserContext";

import "./navbar.scss";

const Navbar = () => {
  const { user } = useUser(); // Use the useUser hook to access user data

  return (
    <div className="navbar">
      <div className="logo">
        <img src="logo.svg" alt="" />
        <span>Dashboard</span>
      </div>
      <div className="icons">
        <img src="/search.svg" alt="" />
        <img src="/app.svg" alt="" />
        <img src="/expand.svg" alt="" />
        <div className="notification">
          <img src="/notifications.svg" alt="" />
          <span>1</span>
        </div>
        {/* {user && ( // Check if user data is available
          <div className="user">
            <img
              src={user.user.gym_image} // Access user data like user_image from the user object
              alt=""
            />
            <span>{user.user.gym_name}</span>
          </div>
        )} */}
        <img src="/settings.svg" alt="" />
      </div>
    </div>
  );
};

export default Navbar;
