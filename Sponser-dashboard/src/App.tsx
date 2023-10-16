import React from "react";
import { createBrowserRouter, RouterProvider } from "react-router-dom";
import Layout from "./Layout";
import Home from "./pages/home/Home";
import RegisterGym from "./pages/register/Register";
import LogIn from "./pages/login/Login";
import { UserProvider } from "./context/UserContext";
import Users from "./pages/users/Users";
import User from "./pages/user/User";
import Posts from "./pages/posts/Posts";
import Post from "./pages/post/Post";
import "./styles/global.scss";

const App: React.FC = () => {
  const router = createBrowserRouter([
    // {
    //   path: "/",
    //   element: <Layout />,
    //   children: [
    //     {
    //       index: true,
    //       element: <Home />,
    //     },

    //     {
    //       path: "/users",
    //       element: <Users />,
    //     },
    //     {
    //       path: "/users/:id",
    //       element: <User />,
    //     },
    //     {
    //       path: "/posts",
    //       element: <Posts />,
    //     },
    //     {
    //       path: "/posts/:id",
    //       element: <Post />,
    //     },
    //   ],
    // },
    {
      path: "/",
      element: <LogIn />,
    },

    {
      path: "/users",
      element: <Users />,
    },

    {
      path: "/register",
      element: <RegisterGym />,
    },
  ]);

  return (
    <UserProvider>
      <RouterProvider router={router} />
    </UserProvider>
  );
};

export default App;
