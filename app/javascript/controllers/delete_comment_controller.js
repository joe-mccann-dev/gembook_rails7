import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["comment"];

  connect() {
    this.deleteComment();
  }

  deleteComment() {
    const comment = this.commentTarget;
    comment.addEventListener('click', function(event) {
      if (!confirm('Are you sure you want to delete this comment?')) {
        event.preventDefault();
      }
    });
  }
}
