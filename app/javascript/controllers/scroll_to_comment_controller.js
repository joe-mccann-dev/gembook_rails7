import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["comment"];

  connect() {
    if (this.commentTarget) {
      this.commentTarget.scrollIntoView({ behavior: "smooth", block: "start" });
    }
  }
}
