defmodule Todo.TopicController do
  use Todo.Web, :controller
  alias Todo.Topic

  def index(conn, _params) do
    topics = Repo.all(Topic)
    render conn, "index.html", topics: topics
  end


  def new(conn, _params) do
    struct = %Topic{}
    params = %{}
    changeset = Topic.changeset(struct,params)
    render conn, "new.html", changeset: changeset
  end


  def create(conn,params) do
    %{"topic" => topic}=params
    changeset =Topic.changeset(%Topic{}, topic)

    case Repo.insert(changeset) do
      {:ok, _topic} ->
        conn
        |>put_flash(:info, "Todo Topic Created")
        |>redirect(to: topic_path(conn, :index))
      {:error, changeset} -> render conn, "new.html", changeset: changeset
    end
  end


  def edit(conn, params) do
    %{"id" => topic_id}= params
    topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(topic)

    render conn, "edit.html", changeset: changeset, topic: topic
  end

  def update(conn, params) do
    %{"id" => topic_id, "topic" => topic}=params
    old_topic =Repo.get(Topic, topic_id)
    changeset = Topic.changeset(old_topic, topic)

    case Repo.update(changeset) do
      {:ok, _topic} ->
        conn
        |>put_flash(:info, "Todo Topic Updated")
        |>redirect(to: topic_path(conn, :index))
      {:error, changeset} -> render conn, "edit.html", changeset: changeset, topic: old_topic
    end
  end


  def delete(conn, params) do
    %{"id" => topic_id} = params
    Repo.get!(Topic, topic_id)
    |> Repo.delete!

    conn
    |> put_flash(:info, "Todo Topic Deleted")
    |> redirect(to: topic_path(conn, :index))
  end
end
