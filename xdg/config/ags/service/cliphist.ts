import { dependencies, bash } from "lib/utils"

class Cliphist extends Service {
    static {
        Service.register(
            this,
            {
                "cliphist-changed": ["jsobject"],
            },
            {
                "cliphist-value": ["jsobject"],
            },
        )
    }

    #history = []

    #proc

    get history() {
        return this.#history
    }

    get proc() {
        return this.#proc
    }

    constructor() {
        super()
        if (dependencies("wl-paste", "cliphist")) {
            this.#proc = Utils.subprocess([
                "wl-paste",
                "--no-newline",
                "--watch",
                "bash",
                "-c",
                "cliphist store && cliphist list | head -n 1",
            ],
            item => this.#onChange(item),
            err => logError(err),
            )
            Utils.subprocess([
                "cliphist",
                "list",
            ],
            item => this.#history.push(item),
            err => logError(err),
            )
        }
    }

    #onChange(item) {
        if (this.history[this.history.length - 1] === item)
            return

        this.#history.unshift(item)
        this.emit("changed")
        this.notify("cliphist-value")
        this.emit("cliphist-changed", this.#history)
    }

    connect(event = "cliphist-changed", callback) {
        return super.connect(event, callback)
    }

    /** @param {string} selected
    */
    select(selected) {
        Utils.execAsync(["bash", "-c", `echo '${selected}' | cliphist decode | wl-copy`])
            .then(out => print(out))
            .catch(err => print(err))
    }

    readonly query = (term: string) => {
        term = term.trim()
        if (!term)
            return this.#history

        return this.#history.filter(item => item.match(term))
    }
}

const cliphist = new Cliphist
export default cliphist
