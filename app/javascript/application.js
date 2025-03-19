// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
// import "@hotwired/turbo-rails"
import { Turbo } from '@hotwired/turbo'
import "controllers"
import "@popperjs/core"
import "bootstrap"
import TurboPower from 'turbo_power'
TurboPower.initialize(Turbo.StreamActions)
