import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'

// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  initialize() {
    this.markers = []
    this.currentPopup = null // Nouvelle variable pour garder une référence au popup actif
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })

    this.map.on('click', () => {
      this.closepopup(); // Ferme le popup si on clique ailleurs sur la carte
    });

    this.#addMarkersToMap()
    this.#fitMapToMarkers(true)
  }

  markersValueChanged() {
    setTimeout(() => {
      this.#removeMarkersToMap()
      this.#addMarkersToMap()
      this.#fitMapToMarkers()
    }, 5);
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window_html)

      const customMarker = document.createElement("div")
      customMarker.innerHTML = marker.marker_html

      const mapBoxMarker = new mapboxgl.Marker(customMarker)
        .setLngLat([marker.lng, marker.lat])
        .addTo(this.map)

      // Ajouter un événement de clic pour afficher l'info-bulle
      mapBoxMarker.getElement().addEventListener('click', (e) => {
        e.stopPropagation(); // Empêche la propagation de l'événement de clic à la carte
        this.#updateInfoBulle(marker.info_window_html, popup);
      });

      this.markers.push(mapBoxMarker)
    })
  }

  #updateInfoBulle(content, popup) {
    const infoBulle = document.getElementById('info-bulle');

    // Affiche le conteneur d'info-bulle
    infoBulle.classList.remove('d-none');

    // Met à jour le contenu de l'info-bulle
    infoBulle.innerHTML = content;

    // Affiche le popup sur la carte
    popup.addTo(this.map);

    // Garde une référence au popup actuel
    this.currentPopup = popup;
  }

  closepopup() {
    // Ferme le popup actif s'il existe
    if (this.currentPopup) {
      this.currentPopup.remove();
      this.currentPopup = null;
    }

    // Masque l'info-bulle
    const infoBulle = document.getElementById('info-bulle');
    infoBulle.classList.add('d-none');
  }

  #fitMapToMarkers(initial_connect) {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))

    let duration = 0
    // Pas d'animation au chargement de la page
    if (!initial_connect) {
      // On récupère le centre de la carte
      const currentCenter = this.map.getCenter();
      // On récupère le centre des limites
      const newCenter = bounds.getCenter();

      // Calcule la distance entre l'ancien centre et le nouveau
      const distance = Math.sqrt(
        Math.pow(currentCenter.lng - newCenter.lng, 2) +
        Math.pow(currentCenter.lat - newCenter.lat, 2)
      );

      // Durée dynamique basée sur la distance, avec un max pour éviter que cela soit trop long
      duration = Math.min(Math.max(distance * 3000, 500), 5000);
    }

    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: duration })
  }

  #removeMarkersToMap() {
    if (this.markers.length > 0) {
      this.markers.forEach((marker) => {
        marker.remove()
      })
    }
  }
}
