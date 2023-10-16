// UserContext.tsx
import {
  createContext,
  useContext,
  useState,
  useEffect,
  ReactNode,
} from "react";

// Define the User and UserData interfaces
interface User {
  token: string;
  user: SponserData;
}

interface SponserData {
  _id: string;
  sponserName: string;
  email: string;
  phoneNo: string;
  password: string;
  token: string;
  // Add other user data properties as needed
}

// Define the UserContextType interface
interface UserContextType {
  user: User | null;
  login: (gymData: SponserData) => void; // Modify the login function signature
  logout: () => void;
}

// Create the UserContext
const UserContext = createContext<UserContextType | undefined>(undefined);

// Create the useUser hook for easy access to user data
export const useUser = () => {
  const context = useContext(UserContext);
  if (!context) {
    throw new Error("useUser must be used within a UserProvider");
  }
  return context;
};

// Create the UserProvider component
export const UserProvider = ({ children }: { children: ReactNode }) => {
  const [user, setUser] = useState<User | null>(null);

  // Load user data from local storage on component mount
  useEffect(() => {
    const storedToken = localStorage.getItem("token");
    const storedUser = localStorage.getItem("user");

    if (storedToken && storedUser) {
      setUser({ token: storedToken, user: JSON.parse(storedUser) });
    }
  }, []);

  // Login function to set user data and store in local storage
  const login = (sponserData: SponserData) => {
    console.log(`Sponser token ${sponserData.token}`);
    setUser({ token: sponserData.token, user: sponserData });
    localStorage.setItem("token", sponserData.token);
    localStorage.setItem("user", JSON.stringify(sponserData));
  };

  // Logout function to clear user data and local storage
  const logout = () => {
    setUser(null);
    localStorage.removeItem("token");
    localStorage.removeItem("user");
  };

  return (
    <UserContext.Provider value={{ user, login, logout }}>
      {children}
    </UserContext.Provider>
  );
};
