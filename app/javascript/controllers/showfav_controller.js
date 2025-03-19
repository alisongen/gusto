import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="showfav"
export default class extends Controller {
  static targets = ["toggleelement"]

  toggle(event) {
    const index = event.params.index

    this.toggleelementTargets.forEach((target) => {
      target.classList.add('d-none')
    })

    this.toggleelementTargets[index].classList.remove('d-none')

    console.log("show fav")
  }
}
