if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_greeting
    # fastfetch
end

# Configuration Apache Jena 5.6.0
set -gx JENA_HOME "$HOME/Documents/etud/m1/web_des_donnees/tp/apache-jena-5.6.0"
fish_add_path "$JENA_HOME/bin"

# Pour le dev Java
set -gx CLASSPATH "$CLASSPATH:$JENA_HOME/lib/*"
