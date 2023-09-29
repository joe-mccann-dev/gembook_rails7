import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["post"];

  connect() {
    this.deletePost();
  }

  deletePost() {
    const post = this.postTarget
    post.addEventListener('click', function(event) {
      if (!confirm('Are you sure you want to delete this post?')) {
        event.preventDefault();
      }
    });
  }
}
