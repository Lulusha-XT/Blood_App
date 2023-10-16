import React, { useState } from "react";
import Axios from "axios";
// import jwt_decode from "jwt-decode";
import { Link, useNavigate } from "react-router-dom";
import { FaUserShield } from "react-icons/fa";
import { AiOutlineSwapRight } from "react-icons/ai";
import { BsFillShieldLockFill } from "react-icons/bs";
import video from "../../assets/logo.mp4";
import logo from "../../assets/logo.png";
import logo1 from "../../assets/logo1.png";
// import "./LogIn.css";
import "../../App.css";
import { useUser } from "../../context/UserContext";

const LogIn = () => {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [loginStatus, setLoginStatus] = useState(""); // State for login status
  const navigate = useNavigate();
  const { login } = useUser();

  const handleLoginStatusClass = () => {
    // Define a function to determine the appropriate class based on loginStatus
    if (loginStatus.includes("successful")) {
      return "greenMessage"; // Use the greenMessage class for success
    } else {
      return "redMessage"; // Use the redMessage class for errors
    }
  };

  const logInUser = async () => {
    try {
      const response = await Axios.post(
        "http://127.0.0.1:8080/api/sponser/login",
        {
          email: email,
          password: password,
        }
      );

      if (response.status === 200) {
        // const token = response.data.token;
        // console.log(token);

        // localStorage.setItem("token", token);
        // const decodedToken = jwt_decode(token);
        // const userId = decodedToken.userId;
        // localStorage.setItem("userId", userId);
        login(response.data.data);
        console.log(response.status);
        setLoginStatus("Login successful");
        navigate("/users");
      } else {
        setLoginStatus("Login failed");
      }
    } catch (error) {
      console.error(error);
      setLoginStatus("Login error");
    }
  };

  return (
    <div className="loginPage flex">
      <div className="container flex">
        <div className="videoDiv">
          <video src={video} autoPlay muted loop></video>
          <div className="textDiv">
            <h2 className="title">Become a Sponsor and Save More Lives!</h2>
            <p>Support Blood Donation!</p>
          </div>
          <div className="footerDiv flex">
            <span className="text">Don't have an account</span>
            <Link to={"/register"}>
              <button className="btn">Sign UP</button>
            </Link>
          </div>
        </div>
        <div className="formDiv flex">
          <div className="headerDiv">
            <img src={logo1} alt="" />
            <h3>Welcome Back!</h3>
          </div>
          <form action="" className="form grid">
            {/* Conditionally set the className of the showMessage element */}
            {loginStatus && (
              <span className={`showMessage ${handleLoginStatusClass()}`}>
                {loginStatus}
              </span>
            )}
            <div className="inputDiv">
              <label htmlFor="username">Username</label>
              <div className="input flex">
                <FaUserShield className="icon" />
                <input
                  type="text"
                  id="username"
                  placeholder="Enter Username"
                  onChange={(event) => {
                    setEmail(event.target.value);
                  }}
                />
              </div>
            </div>
            <div className="inputDiv">
              <label htmlFor="password">Password</label>
              <div className="input flex">
                <BsFillShieldLockFill className="icon" />
                <input
                  type="password"
                  id="password"
                  placeholder="Enter Password"
                  onChange={(event) => {
                    setPassword(event.target.value);
                  }}
                />
              </div>
            </div>
            <button type="button" className="btn flex" onClick={logInUser}>
              <span>Login</span>
              <AiOutlineSwapRight className="icon" />
            </button>
            {/* <span className="forgotPassword">
              Forgot your password?<a href="">Click Here</a>
            </span> */}
          </form>
        </div>
      </div>
    </div>
  );
};

export default LogIn;
