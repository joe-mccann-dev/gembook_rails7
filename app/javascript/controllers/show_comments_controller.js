import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["commentForm"]

  showCommentForm() {
    this.commentFormTarget.classList.toggle("hidden");
  }
} 