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