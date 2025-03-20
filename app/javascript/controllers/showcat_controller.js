import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="showcat"
export default class extends Controller {
  static targets = ["collections", "allLink", "colLink", "friendLink"]

  connect() {
    // Affiche "All" par défaut lors de l'initialisation de la page
    // this.allTarget.classList.remove("d-none");
  }

  toggle(event) {
    // Affiche la section sélectionnée

    if (event.currentTarget.textContent === "All") {
      this.collectionsTarget.classList.add("d-none");
      this.allLinkTarget.classList.remove("btn-no-link");
      this.allLinkTarget.classList.add("btn-link");
      this.colLinkTarget.classList.remove("btn-link");
      this.colLinkTarget.classList.add("btn-no-link");
      this.friendLinkTarget.classList.remove("btn-link");
      this.friendLinkTarget.classList.add("btn-no-link");
    } else if (event.currentTarget.textContent === "Collections") {
      this.collectionsTarget.classList.remove("d-none");
      this.allLinkTarget.classList.remove("btn-link");
      this.allLinkTarget.classList.add("btn-no-link");
      this.colLinkTarget.classList.add("btn-link");
      this.colLinkTarget.classList.remove("btn-no-link");
      this.friendLinkTarget.classList.remove("btn-link");
      this.friendLinkTarget.classList.add("btn-no-link");
    } else if (event.currentTarget.textContent === "Friends") {
      console.log("friends")
      this.collectionsTarget.classList.add("d-none");
      this.allLinkTarget.classList.remove("btn-link");
      this.allLinkTarget.classList.add("btn-no-link");
      this.colLinkTarget.classList.remove("btn-link");
      this.colLinkTarget.classList.add("btn-no-link");
      this.friendLinkTarget.classList.add("btn-link");
      this.friendLinkTarget.classList.remove("btn-no-link");
    }
  }
}
