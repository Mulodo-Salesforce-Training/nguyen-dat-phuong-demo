public class CandidateControllerCX {

    public Attachment mAttachment;

    public String mAttachmentId;

    public CandidateControllerCX(ApexPages.standardController sc) {
        sController = sc;
        mCandidate = (Candidate__c)sc.getRecord();
        candidateServices = new CandidateServices();
    }

    public Attachment getAttachment() {
        mAttachment =  new Attachment();
        return mAttachment;
    }

    public String getAttachmentId(){
        Attachment temp = candidateServices.findAvatar(mCandidate.Id);
        if(temp != null){
            mAttachmentId = temp.Id;
        }
        return mAttachmentId;
    }

    public PageReference save() {
        try {
            processSave();
        } catch (DmlException e) {
            ApexPages.addMessage(
                new ApexPages.Message(ApexPages.severity.ERROR, e.getMessage())
            );
            return ApexPages.currentPage();
        }
        PageReference pg = new PageReference('/' + mCandidate.Id);
        pg.setRedirect(true);
        return pg;
    }

    public PageReference saveAndNew() {
        try {
            processSave();
        } catch (DmlException e) {
            ApexPages.addMessage(
                new ApexPages.Message(ApexPages.severity.ERROR, e.getMessage())
            );
        }
        PageReference pg = ApexPages.currentPage();
        pg.setRedirect(true);
        return pg;
    }

    private void processSave() {
        try {
            Database.upsert(mCandidate);
            if (mAttachment.Name != null) {
                if(mAttachmentId != null){
                    Database.delete(mAttachmentId);
                }
                mAttachment.ParentId = mCandidate.Id;
                Database.insert(mAttachment);
            }
        } catch (DmlException e) {
            throw e;
        }
    }

    private ApexPages.standardController sController = null;
    private Candidate__c mCandidate;
    private CandidateServices candidateServices;
}