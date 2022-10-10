import { AppContext } from "../App";
import React, { useContext, useEffect } from "react";
import ReactPlayer from 'react-player'

function LatestVideo() {
    const { latestPost, setLatestPost } = useContext(AppContext);

    useEffect(() => {
        fetch("http://localhost:3000/videos")
            .then((response) => response.json())
            .then((data) => {
                setLatestPost(data.video_url);
            })
            .catch((error) => console.error(error));
    }, [latestPost]);

    return (
        <div>
            <ReactPlayer url={latestPost} width="30%" height="30%" controls={true} />
        </div>
    );
}

export default LatestVideo;