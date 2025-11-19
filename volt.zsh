# ------------------------------------------------------------------------------
# Function: volt
# Description:
#   A utility for volt-vue CLI.
#   - Executes 'npx volt-vue add' with arguments, enforcing '--outdir app'.
#   - Automatically removes 'add' if the user types 'volt add <component>'.
#
# Usage:
#   volt Button         - Runs 'npx volt-vue add Button --outdir app'
#   volt add Button     - Runs 'npx volt-vue add Button --outdir app'
# ------------------------------------------------------------------------------
volt() {
  case "$1" in
    "-v" | "--version" | "-h" | "--help")
      npx volt-vue "$1"
      return $?
      ;;
  esac

  if [[ "$1" == "add" ]]; then
    shift
  fi

  npx volt-vue add "$@" --outdir app --verbose
}

# ------------------------------------------------------------------------------
# Function: _volt_completions
# Description:
#   Zsh completion function for 'volt'.
#   Suggests components directly as the first argument, aligning with 
#   the volt() function's 'add' shortcut behavior.
# ------------------------------------------------------------------------------
_volt_completions() {
  local curcontext="$curcontext" state line
  typeset -A opt_args

  _arguments -C \
    '(-v --version)-v[Display version information]' \
    '(-h --help)-h[Display help information]' \
    '1: :->component' \
    '*::arg:->argument'

  local -a all_components
  all_components=(
    'Accordion:Accordion groups a collection of contents in panels.'
    'AutoComplete:AutoComplete is an input component that provides real-time suggestions when being typed.'
    'Avatar:Avatar represents people using icons, labels and images.'
    'Badge:Badge is a small status indicator for another element.'
    'Breadcrumb:Breadcrumb provides contextual information about page hierarchy.'
    'Button:Button is an extension to standard input element with icons and theming.'
    'Card:Card is a flexible container component.'
    'Checkbox:Checkbox is an extension to standard checkbox element with theming.'
    'Chip:Chip represents entities using icons, labels and images.'
    'ConfirmDialog:ConfirmDialog uses a Dialog UI that is integrated with the Confirmation API.'
    'DataView:DataView displays data in grid or list layout with pagination and sorting features.'
    'DataTable:DataTable displays data in tabular format.'
    'DatePicker:DatePicker is a form component for date inputs.'
    'Dialog:Dialog is a container to display content in an overlay window.'
    'Divider:Divider is used to separate contents.'
    'Drawer:Drawer is a container component displayed as an overlay.'
    'Fieldset:Fieldset is a collapsible container component.'
    'Fluid:Fluid is a layout component to make descendant components span full width of their container.'
    'IconField:IconField displays an icon inside an input field.'
    'Inplace:Inplace provides an easy to do editing and display at the same time where clicking the output displays the actual content.'
    'InputGroup:Text, icon, buttons and other content can be grouped next to an input.'
    'InputMask:InputMask component is used to enter input in a certain format such as numeric, date, currency, email and phone.'
    'InputNumber:InputNumber is an input component to provide numerical input.'
    'InputOtp:Input Otp is used to enter one time passwords.'
    'InputText:InputText is an extension to standard input element with theming.'
    'Listbox:Listbox is used to select one or more values from a list of items.'
    'Menu:Menu displays a list of items in vertical orientation.'
    'Message:Message component is used to display inline messages.'
    'MeterGroup:MeterGroup displays scalar measurements within a known range.'
    'MultiSelect:MultiSelect is used to select multiple items from a collection.'
    'Paginator:Paginator displays data in paged format and provides navigation between pages.'
    'Panel:Panel is a collapsible container component.'
    'Password:Password displays strength indicator for password fields.'
    'Popover:Popover is a container component that can overlay other components on page.'
    'ProgressBar:ProgressBar is a process status indicator.'
    'RadioButton:RadioButton is an extension to standard radio button element with theming.'
    'Rating:Rating component is a star based selection input.'
    'Select:Select is used to choose an item from a collection of options.'
    'SelectButton:SelectButton is used to choose single or multiple items from a list using buttons.'
    'Skeleton:Skeleton is a placeholder to display instead of the actual content.'
    'Slider:Slider is a component to provide input with a drag handle.'
    'Splitter:Splitter is utilized to separate and resize panels.'
    'Stepper:The Stepper component displays a wizard-like workflow by guiding users through the multi-step progression.'
    'Tabs:Tabs is a container component to group content between different tabs.'
    'Tag:Tag component is used to categorize content.'
    'Textarea:Textarea adds styling and auto-resize functionality to standard textarea element.'
    'Timeline:Timeline visualizes a series of chained events.'
    'Toast:Toast is used to display messages in an overlay.'
    'ToggleButton:ToggleButton is used to select a boolean value using a button.'
    'ToggleSwitch:ToggleSwitch is used to select a boolean value.'
    'Toolbar:Toolbar is a grouping component for buttons and other content.'
    'Tree:Hierarchical data visualization'
  )

  # --- Filtering Logic ---
  typeset -A selected_components # Associative array to track selected components
  local component_name 
  
  # $CURRENT is the index of the word currently being completed (e.g., 2 for the second word).
  # We loop through all words that have been *finalized* before the current one.
  local LAST_INDEX=$((CURRENT - 1))
  
  # Loop through all previously selected words (from index 2 up to the one before $CURRENT).
  for component_name in ${words[2,$LAST_INDEX]}; do
    # We only care about words that are NOT flags.
    if [[ "$component_name" != -* && "$component_name" != "add" ]]; then
      selected_components[$component_name]=1
    fi
  done

  case $state in
    (component)
      local -a suggestions
      suggestions=(
        'add:Download component source code'
        "${all_components[@]}"
      )
      _describe 'volt component or command' suggestions
      ;;

    (argument)
      # 1. Suggest flags that apply to the 'add' operation.
      _arguments '(*)-f[Force download, overwriting existing files]' \
                  '--verbose[Display verbose output during installation]' \
                  '--outdir[Specify custom output directory for components]:OUTDIR:_files'
      
      # 2. Build the filtered list for multi-select.
      local -a filtered_components
      local item

      for item in "${all_components[@]}"; do
        # Extract the component name (the part before the first colon)
        component_name="${item%%:*}"
        
        # If the component is NOT in our selected_components array, add it.
        if [[ -z "${selected_components[$component_name]}" ]]; then
          filtered_components+=("$item")
        fi
      done

      _describe 'volt component name' filtered_components
      ;;
  esac
}

compdef _volt_completions volt
