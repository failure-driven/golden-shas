import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["argumentText", "loading"];

  connect() {
  }

  create() {
    this.argumentTextTarget.disabled = true;
    this.loadingTarget.classList.remove("hidden");
    fetch("/seed", {
      headers: {
        "content-type": "application/json",
      },
      method: "POST",
      body: JSON.stringify({
        phrase: this.argumentTextTarget.value
      })
    })
    .then((response) => response.json())
    .then(response => {
      this.argumentTextTarget.value = response.seed_phrase;
      this.loadingTarget.classList.add("hidden");
    })
    .catch(error => {
      console.log(error)
      this.loadingTarget.classList.add("hidden");
    });
  }
}
