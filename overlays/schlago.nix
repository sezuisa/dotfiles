let
  address = "schlago.hoenle.xyz";
  port = "23235";
in
final: prev: {
  # use 'final' instead of 'pkgs' in overlay for dependencies, as a general principle
  schlago = final.writeShellApplication {
    name = "schlago";

    runtimeInputs = [ final.openssh ];

    text = ''
      function get(){
          # fetch current counter value from server
          ssh -p ${port} ${address} "get"
      }

      function incr(){
          amount=1
          if [[ ''${#} -gt 0 ]]; then
              if [[ ''${#} -gt 1 ]]; then
                  echo "error: Invalid number of arguments" >&2; 
                  exit 1 
              fi
              if ! [[ $1 =~ ^[0-9]+$ ]]; then
                  echo "error: Not a number: $1" >&2; 
                  exit 1 
              fi
              amount=$1
          fi

          # send increment request to schlag-o-meter server
          ssh -p ${port} ${address} "incr $amount"
          # update waybar
          sleep .1
          pkill -RTMIN+4 waybar 
      }

      function set_c(){
          if [[ ''${#} != 1 ]]; then
              echo "error: Invalid number of arguments";
              exit 1
          fi
          if ! [[ $1 =~ ^[0-9]+$ ]]; then
              echo "error: Not a number: $1" >&2; 
              exit 1 
          fi
          # set counter
          ssh -p ${port} ${address} "set $1"
          # update waybar
          sleep .1
          pkill -RTMIN+4 waybar 
      }
                    
      function reset(){
          # reset counter
          ssh -p ${port} ${address} "set 0"
          # update waybar
          sleep .1
          pkill -RTMIN+4 waybar 
      }

      function main() {
          if (( ''${#} == 0 )); then
              get;
              exit 0;
          fi

          case ''${1} in
              get | incr | reset )
                  $1 "''${@:2}";
              ;;
              set )
                  set_c "''${@:2}";
              ;;
              * )
                  echo "unknown command: $1";
                  exit 1;
              ;;
          esac
      }

      main "$@";
    '';
  };
}
