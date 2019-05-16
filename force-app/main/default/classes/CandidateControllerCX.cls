public class CandidateControllerCX {

    public Attachment mAttachment;

    public String mAttachmentId;

    public CandidateControllerCX(ApexPages.standardController sc) {
        sController = sc;
        mCandidate = (Candidate__c)sc.getRecord();
        candidateServices = new CandidateServices();
    }

    public Attachment getAttachment() {
        mAttachment = new Attachment();
        mAttachment.ContentType = 'image/jpeg,image/png';
        return mAttachment;
    }

    public String getAttachmentId() {
        Attachment temp = candidateServices.findAvatar(mCandidate.Id);
        if (temp != null) {
            mAttachmentId = temp.Id;
        }
        return mAttachmentId;
    }

    public PageReference save() {
        try {
            processSave();
        } catch (Exception e) {
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
        } catch (Exception e) {
            ApexPages.addMessage(
                new ApexPages.Message(ApexPages.severity.ERROR, e.getMessage())
            );
        }
        PageReference pg = ApexPages.currentPage();
        pg.setRedirect(true);
        return pg;
    }

    private void processSave() {
        Savepoint sp = Database.setSavepoint();
        Database.upsert(mCandidate);
        System.debug(mAttachment);
        if (mAttachment.Name != null) {
            String contentType = mAttachment.ContentType;
            if (contentType.equalsIgnoreCase('image/jpeg') || contentType.equalsIgnoreCase('image/png')) {
                if (mAttachment.Body.size() <= 5242880) {
                    if (mAttachmentId != null) {
                        Database.delete(mAttachmentId);
                    }
                    mAttachment.ParentId = mCandidate.Id;
                    Database.insert(mAttachment);
                } else {
                    Database.rollback(sp);
                    throw new UploadException('File Size Maximum 5MB');
                }
            } else {
                Database.rollback(sp);
                throw new UploadException('File extension must be jpg, png');
            }
        }
    }

    private ApexPages.standardController sController = null;
    private Candidate__c mCandidate;
    private CandidateServices candidateServices;
}