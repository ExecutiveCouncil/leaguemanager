// CAPTURA EVENTOS
Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(beginRequest);
Sys.WebForms.PageRequestManager.getInstance().add_endRequest(endRequest);

function beginRequest(sender, args) {
    if (ShowWaitScreen() == true) {
        $find('ModalProgress').show();
    }
}

function endRequest(sender, args) {
    $find('ModalProgress').hide();
}


function ShowWaitScreen() {
    if ($('#DisableWaitScreen').length) {
        //Sin pantalla de espera
        return false;
    }
    //con pantalla de espera.
    return true;
}

//Regresa a la página de inicio (default.aspx) desde cualquier punto de la aplicación
//NOTA: Funciona incluso desde ventanas de PopUp.
function GoHome() {
    if (window.top !== window.self) {
        window.top.location = '../pages/home.aspx';
    } else {
        window.location = '../pages/home.aspx';
    }
}