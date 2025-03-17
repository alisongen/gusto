import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="showcat"
export default class extends Controller {
  static targets = ["all", "collections", "friends", "allLink"]

  connect() {
    // Affiche "All" par défaut lors de l'initialisation de la page
    this.allTarget.classList.remove("d-none");
  }

  toggle(event) {
    // Affiche la section sélectionnée
    if (event.currentTarget.textContent === "All") {
      this.allTarget.classList.remove("d-none");
      this.collectionsTarget.classList.add("d-none");
      this.friendsTarget.classList.add("d-none");
      this.allLinkTarget.classList.remove("btn-no-link");
      this.allLinkTarget.classList.add("btn-link");
    } else if (event.currentTarget.textContent === "Collections") {
      this.collectionsTarget.classList.remove("d-none");
      this.allTarget.classList.add("d-none");
      this.friendsTarget.classList.add("d-none");
      this.allLinkTarget.classList.remove("btn-link");
      this.allLinkTarget.classList.add("btn-no-link");
    } else if (event.currentTarget.textContent === "Friends") {
      this.friendsTarget.classList.remove("d-none");
      this.allTarget.classList.add("d-none");
      this.collectionsTarget.classList.add("d-none");
      this.allLinkTarget.classList.remove("btn-link");
      this.allLinkTarget.classList.add("btn-no-link");
    }
  }
}
