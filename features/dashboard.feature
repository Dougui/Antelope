Feature: Dashboard
    In order to visit the home page
    As a visitor
    I want to see informations

    Scenario: View the home page when not logged
        When I am on the home page
        Then I should see "S'inscrire"
        Then I should see "Me rappeler mon not de passe"
        Then I should see "Se connecter"

    Scenario: View the home page when logged
        Given I am a logged user
        When I am on the home page
        Then I should see "Supprimer mon compte"
        Then I should see "Se déconnecter"
        Then I should see "Modifier mon compte"