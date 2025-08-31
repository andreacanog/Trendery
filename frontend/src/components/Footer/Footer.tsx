import React from "react";
import "./Footer.css";

const Footer: React.FC = () => {
  return (
    <footer className="footer">
      <p>© 2025 Trendery. All rights reserved.</p>
      <nav>
        <ul>
          <li>
            <a href="/support">Support</a>
          </li>
          <li>
            <a href="/faq">FAQ</a>
          </li>
          <li>
            <a href="/terms">Terms of Service</a>
          </li>
          <li>
            <a href="/privacy">Privacy Policy</a>
          </li>
        </ul>
      </nav>
    </footer>
  );
};

export default Footer;
