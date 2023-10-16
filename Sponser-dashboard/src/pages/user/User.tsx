import { useEffect, useState } from "react";
import Single from "../../components/single/Single";
import "./user.scss";

// Define an interface for the structure of userData
interface UserData {
  id: number;
  img?: string;
  title: string;
  info: object;
  chart?: {
    dataKeys: { name: string; color: string }[];
    data: object[];
  };
  activities?: { time: string; text: string }[];
}

const User = () => {
  const [userData, setUserData] = useState<UserData | null>(null);

  useEffect(() => {
    // Make an API request to fetch user data
    // Replace 'your-api-endpoint' with the actual API endpoint
    fetch("your-api-endpoint")
      .then((response) => response.json())
      .then((data: UserData) => {
        setUserData(data);
      })
      .catch((error) => {
        console.error("Error fetching user data:", error);
      });
  }, []);

  return <div className="user">{userData && <Single {...userData} />}</div>;
};

export default User;
