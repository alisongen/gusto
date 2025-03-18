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
    this.#fitMapToMarkers()
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
        .setPopup(popup)
        .addTo(this.map)

      this.markers.push(mapBoxMarker)
    })
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))

    const currentCenter = this.map.getCenter(); // Get current map center
    const newCenter = bounds.getCenter(); // Get new bounds center

    // Calculate distance between current center and new center
    const distance = Math.sqrt(
      Math.pow(currentCenter.lng - newCenter.lng, 2) +
      Math.pow(currentCenter.lat - newCenter.lat, 2)
    );

    // Set a dynamic duration based on distance (clamped for reasonable speed)
    const duration = Math.min(Math.max(distance * 5000, 500), 5000); // 0.5s to 3s

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
