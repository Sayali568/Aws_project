const navLinks = [...document.querySelectorAll(".nav a")];
const sections = [...document.querySelectorAll("main section[id], main .hero[id]")];

navLinks.forEach((link) => {
  link.addEventListener("click", () => {
    navLinks.forEach((item) => item.classList.remove("active"));
    link.classList.add("active");
    document.querySelector(".sidebar").classList.remove("open");
  });
});

const observer = new IntersectionObserver((entries) => {
  entries.forEach((entry) => {
    if (!entry.isIntersecting) return;
    navLinks.forEach((link) => {
      link.classList.toggle("active", link.getAttribute("href") === `#${entry.target.id}`);
    });
  });
}, { rootMargin: "-20% 0px -65%", threshold: 0 });

sections.forEach((section) => observer.observe(section));

document.querySelector(".menu-button").addEventListener("click", (event) => {
  const sidebar = document.querySelector(".sidebar");
  const isOpen = sidebar.classList.toggle("open");
  event.currentTarget.setAttribute("aria-expanded", String(isOpen));
});

const refreshButton = document.querySelector("#refreshButton");
const toast = document.querySelector("#toast");
const cpuMetric = document.querySelector("#cpuMetric");

refreshButton.addEventListener("click", () => {
  refreshButton.classList.add("loading");
  refreshButton.disabled = true;
  setTimeout(() => {
    const cpu = 32 + Math.floor(Math.random() * 15);
    cpuMetric.textContent = `${cpu}%`;
    refreshButton.classList.remove("loading");
    refreshButton.disabled = false;
    toast.classList.add("show");
    setTimeout(() => toast.classList.remove("show"), 2200);
  }, 700);
});
