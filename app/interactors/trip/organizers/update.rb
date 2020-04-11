class Trip::Organizers::Update
  include Interactor::Organizer

  organize Trip::Start, Trip::Complete
end
