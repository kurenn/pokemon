import { Controller } from "@hotwired/stimulus";
import { get } from "@rails/request.js";

export default class extends Controller {
  static targets = ["spinner", "text"];

  connect() {
    this.offset = 20;
    console.log(this.spinnerTarget);
  }

  async fetch(e) {
    e.preventDefault();

    this.element.disabled = true;
    this.spinnerTarget.classList.remove("hidden");
    this.textTarget.innerHTML = "Loading...";

    await get("/pokemons", {
      responseKind: "turbo-stream",
      query: { offset: this.offset },
    });

    this.offset += 20;
    this.element.disabled = false;
    this.spinnerTarget.classList.add("hidden");
    this.textTarget.innerHTML = "Load more";
  }
}
