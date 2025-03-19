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
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })

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
      // Créer un popup pour chaque marqueur, mais ne l'utiliserons pas directement
      const popup = new mapboxgl.Popup().setHTML(marker.info_window_html)

      const customMarker = document.createElement("div")
      customMarker.innerHTML = marker.marker_html

      const mapBoxMarker = new mapboxgl.Marker(customMarker)
        .setLngLat([marker.lng, marker.lat])
        .addTo(this.map)

      // Ajouter un événement de clic pour mettre à jour l'info-bulle en bas
      mapBoxMarker.getElement().addEventListener('click', () => {
        this.#updateInfoBulle(marker.info_window_html);
      });

      this.markers.push(mapBoxMarker)
    })
  }

  #updateInfoBulle(content) {
    const infoBulle = document.getElementById('info-bulle');

    // Affiche le conteneur d'info-bulle
    infoBulle.style.display = 'block';

    // Met à jour le contenu de l'info-bulle
    infoBulle.innerHTML = content;
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
