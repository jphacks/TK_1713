// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$( () => {
    const button = $(".select-button");
    button.on("click", () => {
        const id = button.data("id");
        if (sessionStorage.getItem(id)) {
            return;
        }
        sessionStorage.setItem(id, button.data("name"));

        const sidebarSelections = document.querySelector(".sidebar-selections");
        const dom = document.createElement("div");
        dom.className = "selected-content";
        dom.textContent = button.data("name");
        sidebarSelections.appendChild(dom);
    });
});
