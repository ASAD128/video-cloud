import { AppContext } from "../App";
import React, { useContext } from "react";

function FileForm() {
    const { latestPost, setLatestPost } = useContext(AppContext);

    function handleSubmit(event) {
        event.preventDefault();
        const data = new FormData();

        data.append("video[title]", event.target.title.value);
        data.append("video[category_id]", 2);
        data.append("video[file]", event.target.file.files[0]);
        submitToAPI(data);
    }
    function submitToAPI(data) {
        fetch("http://localhost:3000/videos", {
            method: "POST",
            body: data,
        })
            .then((response) => response.json())
            .then((data) => {
                console.log(data)
            })
            .catch((error) => console.error(error));
    }
    return (
        <div>
            <h1>Video Upload</h1>
            <form onSubmit={(e) => handleSubmit(e)}>
                <label htmlFor="title">Title</label>
                <input type="text" name="title" id="title" />
                <br />

                <label htmlFor="file">Video</label>
                <input type="file" name="file" id="file" />
                <br />

                <button type="submit">Upload Video</button>
            </form>
        </div>
    );
}

export default FileForm;