# Sync your forks

This action locks a pull-request

## Example usage

```yml
  - name: sync my fork
    uses: sudo-bot/action-fork-sync@v1.0.1
    with:
        branches: master, STABLE, next
        source-url: "https://${{ secrets.BOT_TOKEN }}:x-oauth-basic@github.com/myname/myproject.git"
        fork-url: "https://${{ secrets.BOT_TOKEN }}:x-oauth-basic@github.com/myname/myproject.git"
        dry-run: "true" # remove this line to make sync effective
        clone-depth: "100" # optional, defaults to 100
```
