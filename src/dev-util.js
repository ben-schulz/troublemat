function sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

async function watcherLoop(milliseconds){
    while(true){
        await sleep(milliseconds);
        window.location.reload();
    }
}
