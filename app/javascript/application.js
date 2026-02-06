// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";

document.addEventListener("DOMContentLoaded", () => {
  const dropZone = document.getElementById("drop-zone");
  const fileInput = document.getElementById("file-input");
  const fileName = document.getElementById("file-name");

  if (!dropZone) return;

  dropZone.addEventListener("click", () => {
    fileInput.click();
  });

  dropZone.addEventListener("dragover", (e) => {
    e.preventDefault();
    dropZone.classList.add("dragover");
  });

  dropZone.addEventListener("dragleave", () => {
    dropZone.classList.remove("dragover");
  });

  dropZone.addEventListener("drop", (e) => {
    e.preventDefault();
    dropZone.classList.remove("dragover");

    const files = e.dataTransfer.files;
    if (files.length > 0) {
      fileInput.files = files;
      fileName.textContent = files[0].name;
    }
  });

  fileInput.addEventListener("change", () => {
    if (fileInput.files.length > 0) {
      fileName.textContent = fileInput.files[0].name;
    }
  });
});
import "@hotwired/turbo-rails";

document.addEventListener("DOMContentLoaded", () => {
  const drawer = document.querySelector(".sets");
  let isOpen = false;

  document.addEventListener("mousemove", (e) => {
    if (e.clientX < 20 && !isOpen) {
      drawer.classList.add("open");
      isOpen = true;
    } else if (e.clientX > 260 && isOpen) {
      // mouse moved away
      drawer.classList.remove("open");
      isOpen = false;
    }
  });
});
