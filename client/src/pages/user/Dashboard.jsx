import UpdateUserForm from "../user/dashboard/UpdateUserForm";
import InfosUser from "../user/dashboard/InfosUser";

function Dashboard() {
  

  return (
    <main className="dashboard">
     
      <InfosUser />

      <UpdateUserForm />
    </main>
  );
}

export default Dashboard;
