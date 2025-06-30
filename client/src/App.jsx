import Header from "./layout/Header";
import AppRoutes from "./routes/AppRoutes";
import Footer from "./layout/Footer";


function App() {

  function handlePathname() {
    return location.pathname === "/"
      ? "home"
      : location.pathname.slice(1, location.pathname.length);
  }

  return (
    <div className="App">
        <Header />
      <main className="container" id={handlePathname()}>
        <AppRoutes />
      </main>
        <Footer />
    </div>
  )
}

export default App;
