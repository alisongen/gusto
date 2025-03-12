import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="reset"
export default class extends Controller {
  static targets = ["button", "textField", "list"]
  // Event "clear" pour effacer le champ de recherche
  clear() {
    // A l'activation de "clear"
    // Le champ de recherche se vide
    this.textFieldTarget.value = ""
    // On ajoute la classe "d-none" au bouton pour le supprimer
    this.buttonTarget.classList.add("d-none");
    // On clear la liste de résultats
    this.listTarget.remove()
  }
  // Event "changeInput" afin de supprimer ou d'afficher le bouton
  changeInput(event) {
    // Si, lors du trigger de l'event ("change"), le champ de recherche est vide
    if (event.currentTarget.value === "") {
      // On ajoute la classe "d-none" au bouton pour le supprimer
      this.buttonTarget.classList.add("d-none")
      // On clear la liste de résultats
      this.listTarget.remove()
    }
    // Sinon
    else {
      // On supprime la classe "d-none" au bouton pour l'afficher
      this.buttonTarget.classList.remove("d-none")
    }
  }
}
