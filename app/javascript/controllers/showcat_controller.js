import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="showcat"
export default class extends Controller {
  static targets = ["all", "collections", "friends"]

  toggle(event) {
    if (event.currentTarget.textContent === "All") {
      this.allTarget.classList.remove("d-none")
      this.collectionsTarget.classList.add("d-none")
      this.friendsTarget.classList.add("d-none")
    } else if (event.currentTarget.textContent === "Collections") {
      this.collectionsTarget.classList.remove("d-none")
      this.allTarget.classList.add("d-none")
      this.friendsTarget.classList.add("d-none")
    // } else if (event.currentTarget.textContent === "Friends") {
    //   this.friendsTarget.classList.remove("d-none")
    //   this.allTarget.classList.add("d-none")
    //   this.collectionsTarget.classList.add("d-none")
    }
  }
}
