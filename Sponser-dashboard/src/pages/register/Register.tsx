import React, { useState } from "react";
import Axios from "axios";
import { Link } from "react-router-dom";
import { FaUserShield } from "react-icons/fa";
import { MdEmail } from "react-icons/md";
import { AiOutlineSwapRight } from "react-icons/ai";
import { BsFillShieldLockFill } from "react-icons/bs";
import video from "../../assets/logo.mp4";
// import logo from "../../assets/logo.png";
import logo1 from "../../assets/logo1.png";
// import "./Register.css";
import "../../App.css";

const Register = () => {
  const [email, setEmail] = useState("");
  const [phoneNo, setPhoneNo] = useState("");
  const [userName, setUserName] = useState("");
  const [password, setPassword] = useState("");
  const [registrationStatus, setRegistrationStatus] = useState("");

  const handleRegistrationStatusClass = () => {
    if (registrationStatus.includes("successful")) {
      return "greenMessage";
    } else {
      return "redMessage";
    }
  };

  const createUser = async () => {
    try {
      const response = await Axios.post(
        "http://127.0.0.1:8080/api/sponser/register",
        {
          sponserName: userName,
          phoneNo: phoneNo,
          email: email,
          password: password,
        }
      );

      if (response.status === 201) {
        setRegistrationStatus("Registration successful");
      } else {
        setRegistrationStatus("Registration failed");
      }
    } catch (error) {
      console.error(error);
      setRegistrationStatus("Registration error");
    }
  };

  return (
    <div className="registerPage flex">
      <div className="container flex">
        <div className="videoDiv">
          <video src={video} autoPlay muted loop></video>
          <div className="textDiv">
            <h2 className="title">Become a Sponsor and Save More Lives!</h2>
            <p>Support Blood Donation!</p>
          </div>
          <div className="footerDiv flex">
            <span className="text">Have an account?</span>
            <Link to={"/"}>
              <button className="btn">Login</button>
            </Link>
          </div>
        </div>
        <div className="formDiv flex">
          <div className="headerDiv">
            <img src={logo1} alt="" />
            <h3>Welcome Back!</h3>
          </div>
          <form action="" className="form grid">
            {registrationStatus && (
              <span
                className={`showMessage ${handleRegistrationStatusClass()}`}
              >
                {registrationStatus}
              </span>
            )}

            <div className="inputDiv">
              <label htmlFor="username">Username</label>
              <div className="input flex">
                <FaUserShield className="icon" />
                <input
                  type="text"
                  id="username"
                  placeholder="Enter Sponsor Name"
                  onChange={(event) => {
                    setUserName(event.target.value);
                  }}
                />
              </div>
            </div>
            <div className="inputDiv">
              <label htmlFor="phoneNo">Phone No</label>
              <div className="input flex">
                <FaUserShield className="icon" />
                <input
                  type="text"
                  id="phoneNo"
                  placeholder="Enter Phone Number"
                  onChange={(event) => {
                    setPhoneNo(event.target.value);
                  }}
                />
              </div>
            </div>

            <div className="inputDiv">
              <label htmlFor="email">Email</label>
              <div className="input flex">
                <MdEmail className="icon" />
                <input
                  type="text"
                  id="email"
                  placeholder="Enter Email"
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

            <button type="button" className="btn flex" onClick={createUser}>
              <span>Register</span>
              <AiOutlineSwapRight className="icon" />
            </button>
          </form>
        </div>
      </div>
    </div>
  );
};

export default Register;
