// import $ from "jquery";
console.log("sidebar");
$( () => {
    const sidebarSelections = $(".sidebar-selections");
    if (sessionStorage.length !== 0) {
        for (var i = 0; i < sessionStorage.length; i++) {
            const id = sessionStorage.key(i);
            const dom = document.createElement("div");
            dom.className = "selected-content";
            dom.textContent = sessionStorage.getItem(id);
            sidebarSelections.append(dom);
        }
    } else {
    }

    const startButton = $(".start-button")
    if (startButton !== null) {
        const ids = []
        startButton.on("click", () => {
            if (sessionStorage.length !== 0) {
                for (var i = 0; i < sessionStorage.length; i++) {
                    const id = sessionStorage.key(i);
                    ids.push(id);
                }
            }
            location.href="/rempi?ids="+String(ids);
        });
    }
});
