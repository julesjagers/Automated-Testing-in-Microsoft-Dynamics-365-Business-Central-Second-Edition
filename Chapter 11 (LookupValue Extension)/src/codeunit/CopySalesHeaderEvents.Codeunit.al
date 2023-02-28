codeunit 50006 "CopySalesHeaderEvents"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnAfterCopySalesHeaderDone', '', false, false)]
    local procedure OnAfterCopySalesHeaderEvent(var ToSalesHeader: Record "Sales Header"; FromSalesHeader: Record "Sales Header")
    begin
        ToSalesHeader."Lookup Value Code" := FromSalesHeader."Lookup Value Code";
    end;
}