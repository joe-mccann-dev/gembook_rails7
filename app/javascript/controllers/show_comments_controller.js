import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["comments"]

  showCommentForm() {
    this.commentsTarget.classList.toggle("hidden");
  }
} 