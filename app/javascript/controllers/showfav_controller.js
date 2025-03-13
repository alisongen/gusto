import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="showfav"
export default class extends Controller {
  connect() {
    console.log("ok")
  }
}
