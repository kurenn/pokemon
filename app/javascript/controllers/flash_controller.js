import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    setTimeout(() => this.dismiss(), 3000);
  }

  dismiss() {
    this.element.classList.remove("animate__fadeInRight");
    this.element.classList.add("animate__fadeOutRight");

    this.element.addEventListener("animationend", () => {
      this.element.remove();
    });
  }
}
