class DocsController < ApplicationController

  def index
    @docs = []
    User.each { |u| @docs += u.docs }
    @docs.sort! {|a, b| b.attachment_updated_at <=> a.attachment_updated_at }
  end

  def create
    respond_to do |format|
      if params[:user][:files]
        params[:user][:files].each { |file| current_user.docs.create(attachment: file) }
        format.html { redirect_to docs_path, notice: 'New file was successfully added.' }
        format.json { head :no_content }
      else
        format.html { redirect_to docs_path, alert: "New file wasn't added!" }
        format.json { head :no_content }
      end
    end
  end

  def destroy
    @doc = User.find(params[:user_id]).docs.find(params[:id])
    @doc.destroy
    respond_to do |format|
      format.html { redirect_to docs_url, notice: 'File was deleted.' }
      format.json { head :no_content }
    end
  end

  private
  def doc_params
    params.require(:doc).permit(:attachment)
  end

end
