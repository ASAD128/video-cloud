import logo from "./logo.svg";
import "./App.css";
import { createContext, useState } from "react";
import React from "react";
import FileForm from "./components/FileForm";
import LatestVideo from "./components/LatestVideo";

export const AppContext = createContext(null);

function App() {
    const [latestPost, setLatestPost] = useState(AppContext);
    return (
        <AppContext.Provider value={{ latestPost, setLatestPost }}>
          <div className="App">
            <FileForm />
            <LatestVideo />
          </div>
        </AppContext.Provider>
    );
}

export default App;