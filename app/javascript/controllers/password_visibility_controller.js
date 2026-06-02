import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "input", "icon" ]

  toggle() {
    if (this.inputTarget.type === "password") {
      this.inputTarget.type = "text"
      this.showHideIcon(true)
    } else {
      this.inputTarget.type = "password"
      this.showHideIcon(false)
    }
  }

  showHideIcon(show) {
    if (show) {
      // Show eye-off icon
      this.iconTarget.innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5">
        <path stroke-linecap="round" stroke-linejoin="round" d="M3.98 8.223A10.477 10.477 0 001.934 12C3.226 16.338 7.244 19.5 12 19.5c.993 0 1.953-.138 2.863-.395M6.228 6.228A10.45 10.45 0 0112 4.5c4.756 0 8.773 3.162 10.065 7.498a10.523 10.523 0 01-4.293 5.774M6.228 6.228L3 3m3.228 3.228l3.65 3.65m7.894 7.894L21 21m-3.228-3.228l-3.65-3.65m0 0a3 3 0 10-4.243-4.243m4.242 4.242L9.88 9.88" />
      </svg>`
    } else {
      // Show eye icon
      this.iconTarget.innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5">
        <path stroke-linecap="round" stroke-linejoin="round" d="M2.036 12.322a1.012 1.012 0 010-.644C3.483 8.653 7.073 5.625 11.25 5.625c4.177 0 7.767 3.028 9.213 6.697a1.012 1.012 0 010 .644C19.017 15.347 15.427 18.375 11.25 18.375c-4.177 0-7.767-3.028-9.213-6.697z" />
        <path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
      </svg>`
    }
  }
}
