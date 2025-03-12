import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="reset"
export default class extends Controller {
  static targets = ["button", "textField", "list"]

  connect() {
    console.log("ok")
  }

  clear() {
    this.textFieldTarget.value = ""
    this.buttonTarget.classList.add("d-none");
    this.listTarget.remove();
  }

  changeInput(event) {
    if (event.currentTarget.value === "") {
      this.buttonTarget.classList.add("d-none")
    }
    else {
      this.buttonTarget.classList.remove("d-none")
    }
  }
}
