
function joim() {
    const urlParams = new URLSearchParams(window.location.search);
    const inviteID = urlParams.get("invite");

    if (inviteID) {
        const [placeId, jobId] = inviteID.split(";");

        if (placeId && jobId) {
            window.location.href = ("roblox://experiences/start?placeId=" + placeId +  "&gameInstanceId=" + jobId)

            window.location.href = "https://rblx.games/" + placeId
        } else {

        }
    } else {

    }
}
window.onload = joim;