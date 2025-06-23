function loadXMLXSL(xmlPath, xslPath, page = "accueil", lang = "fr") {
  // Met à jour l'URL sans recharger la page
  const newUrl = `index.html?page=${page}&lang=${lang}`;
  history.pushState({}, "", newUrl);

  const parser = new DOMParser();
  Promise.all([fetch(xmlPath), fetch(xslPath)])
    .then(([xmlRes, xslRes]) => Promise.all([xmlRes.text(), xslRes.text()]))
    .then(([xmlText, xslText]) => {
      const xml = parser.parseFromString(xmlText, "application/xml");
      const xsl = parser.parseFromString(xslText, "application/xml");

      const processor = new XSLTProcessor();
      processor.importStylesheet(xsl);
      const result = processor.transformToFragment(xml, document);

      const container = document.getElementById("content");
      container.innerHTML = "";
      container.appendChild(result);
    });
}

// Initialisation au chargement de la page
const urlParams = new URLSearchParams(window.location.search);
const page = urlParams.get("page") || "accueil";
const lang = urlParams.get("lang") || "fr";
loadXMLXSL(`${lang}/${page}.xml`, "portfolio.xsl", page, lang);

// Gestion du bouton retour du navigateur
window.addEventListener("popstate", () => {
  const urlParams = new URLSearchParams(window.location.search);
  const page = urlParams.get("page") || "accueil";
  const lang = urlParams.get("lang") || "fr";
  loadXMLXSL(`${lang}/${page}.xml`, "portfolio.xsl", page, lang);
});
