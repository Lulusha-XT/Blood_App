import React from "react";
import { Outlet } from "react-router-dom";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import Navbar from "./components/navbar/Navbar";
// import Menu from "./components/menu/Menu";
import Footer from "./components/footer/Footer";

const queryClient = new QueryClient();

const Layout: React.FC = () => {
  return (
    <div className="main">
      <Navbar />
      <div className="container">
        <div className="menuContainer">{/* <Menu /> */}</div>
        <div className="contentContainer">
          <QueryClientProvider client={queryClient}>
            <Outlet />
          </QueryClientProvider>
        </div>
      </div>
      <Footer />
    </div>
  );
};

export default Layout;
